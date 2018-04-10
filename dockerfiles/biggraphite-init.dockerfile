FROM my_bg_carbon

RUN apk add --update --no-cache py2-pip bash
RUN pip install cqlsh
VOLUME ["/bg_init","/shared","/biggraphite"]
CMD /bg_init/init.sh