---
title: Shared Volumes
description: Use bind mounts and docker volumes to save files.
aliases:
  - /use/shared_volumes/
---

A common configuration with Rocker containers is to share volumes between the container and the host filesystem.  This allows the container to access and modify local files in directories you specify.  In this way, the container can be treated as ephemeral while files you create will persist after the container is destroyed. Because the container only has access to files within the directories you specify, this can also prevent a user from accidentally modifying unrelated files on the file system when using software inside the container. 

To share a volume with the host we use the `-v` or `--volume` flag. Simply indicate the location on the host machine on the left side of `:`, and indicate the location on the container to the right.  For instance:

```bash
docker run -d  -e PASSWORD=yourpassword -p 8787:8787 -v /Users/bob/Documents:/home/rstudio/Documents rocker/rstudio
```

would link the User `bob`'s Documents directory to the default `rstudio` user's directory on the container.  The above example shows a typical path on a Mac host, which can share any subdirectory under `Users`.  A Linux host can link an arbitrary path.  The same method should work on Windows paths as well, e.g. 

```bash
docker run -d  -e PASSWORD=yourpassword -p 8787:8787 -v /c/Users/foobar:/home/rstudio/foobar rocker/rstudio
```

Would share the host's file `C:/Users/foobar`
