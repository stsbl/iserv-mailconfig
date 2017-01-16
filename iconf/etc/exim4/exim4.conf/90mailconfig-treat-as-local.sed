/^\s*acl_check_rcpt:/a \
    # Always accept mails from domains, which should treated als local\
    accept\
      sender_domains = +treat_as_local_domains\
