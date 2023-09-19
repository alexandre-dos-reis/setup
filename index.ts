interface Dockerfile {
  blocks: Array<DockerfileBlock>;
}

interface DockerfileBlock {
  instructions: {
    verb: "RUN" | "COPY" | "SOME";
  };
}
