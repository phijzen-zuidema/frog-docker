# frog-docker
A dockerfile that builds frog from scratch, following the instructions from 
<a href="https://frognlp.readthedocs.io/en/latest/installation.html">frog documentation</a>.

To build and publish the Dockerfile:<br>
`docker build -t phijzenzuidema/frog:<VERSION> -f Dockerfile .`
`docker push phijzenzuidema/frog:<VERSION>`
