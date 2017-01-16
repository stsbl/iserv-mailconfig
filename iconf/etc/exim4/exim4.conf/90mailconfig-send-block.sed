/^\s*acl_check_rcpt:/a \
    # Deny internal sending of mails to groups without mail_int flag\
    deny\
      authenticated = \*\
      condition = ${lookup pgsql{ \\\
        SELECT 1 FROM groups g WHERE g.act = '${quote_pgsql:$local_part}' \\\
        AND NOT EXISTS (SELECT 1 FROM groups_flag f WHERE f.act=g.act AND \\\
        f.flag='mail_int') AND NOT EXISTS (SELECT 1 FROM users_priv p \\\
        WHERE p.act = '${quote_pgsql:$authenticated_id}' AND p.privilege = \\\
        'mail_all_grps' LIMIT 1)}}\
      # Admins must always reachable\
      !local_parts = admins\
      # only apply for local domains\
      domains = +local_domains\
      message = This recipient is not allowed to receive e-mail from other \\\
        internal e-mail accounts.\\n\\nDieser Empfänger darf keine E-Mails von \\\
 	anderen internen E-Mail-Konten empfangen.\
