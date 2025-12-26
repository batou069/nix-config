{}: {
  services = {
    signaturepdf = {
      enable = true;
      port = 8082;
      extraConfig = {
        max_file_uploads = "201";
        post_max_size = "24M";
        upload_max_filesize = "24M";
      };
    };
  };
}
