# Dockerfile for Python whisk docker action
FROM smartpages/nuance_caller_base

EXPOSE 8060

COPY ./requirements.txt /app/requirements.txt

COPY . /app

COPY start.sh /usr/bin/

ENV LOG_PATH=/var/log/celery \
    NLTK_DATA=$APP_HOME/nltk_data

RUN yum install -y tkinter tk-devel && rm -f /app/db.sqlite3 && rm -rf /app/machinelearning && \
    python3 -m pip install PyPDF2 Cython && python3 -m pip install -r /app/requirements.txt && \
    python3 -m nltk.downloader stopwords && python3 -m textblob.download_corpora && \
    mv /root/nltk_data $APP_HOME && mkdir -p $LOG_PATH /app/dll && \
    cd /app/ocr_extraction && g++ -fPIC -Wall -O3 -shared -I/usr/local/include/nuance-omnipage-csdk-20.3-19101.1700 -L/usr/local/lib/nuance-omnipage-csdk-lib64-20.3-19101.1700 -lkernelapi -lrecapiplus -c nuanceCallLib.c && \
    cd /app/ocr_extraction && g++ -fPIC -Wall -O3 -shared -I/usr/local/include/nuance-omnipage-csdk-20.3-19101.1700 -L/usr/local/lib/nuance-omnipage-csdk-lib64-20.3-19101.1700 -lkernelapi -lrecapiplus -c nuanceOCRConvert.cpp && \
    cd /app/ocr_extraction && g++ -shared nuanceCallLib.o nuanceOCRConvert.o -o nuanceCallLib.so -I/usr/local/include/nuance-omnipage-csdk-20.3-19101.1700 -L/usr/local/lib/nuance-omnipage-csdk-lib64-20.3-19101.1700 -lkernelapi -lrecapiplus && \
    mv /app/ocr_extraction/nuanceCallLib.so /app/dll/nuanceCallLib.so

ENTRYPOINT [""]

WORKDIR /app

CMD ["start.sh"]

RUN rm -r /app/ocr_extraction/nuanceOCRConvert.cpp /app/ocr_extraction/nuanceOCRConvert.h /app/ocr_extraction/nuanceCallLib.c && \
    chown -R $UID:$GID $LOG_PATH $APP_HOME /app/dll/