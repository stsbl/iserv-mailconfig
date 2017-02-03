/^\s*acl_check_rcpt:/a \
    # Always accept mails from domains, which should treated als local\
    accept\
      sender_domains = +treat_as_local_domains\

/^\s*acl_check_rcpt:/a \
    # Always accept mails to domains, which should treated als local\
    accept\
      authenticated = *\
      domains = +treat_as_local_domains\
      # do not include users which send spam
      !condition = ${lookup pgsql{ SELECT 1 FROM exim_send_block \
        WHERE act = '${quote_pgsql:$authenticated_id}' }}\
