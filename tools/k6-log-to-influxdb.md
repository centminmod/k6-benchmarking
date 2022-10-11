```
./k6-log-to-influxdb.sh 

Usage:

./k6-log-to-influxdb.sh convert /path/to/summary-raw-scenarios-multi.gz
```
```
./k6-log-to-influxdb.sh convert /root/tools/k6/summary-raw-scenarios-multi.gz

     Saved InfluxDB formatted data files (120 lines) at:
     /home/k6-workdir/influxdb-vus.log (120)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir//home/k6-workdir/influxdb-vus.log

     Saved & Split InfluxDB formatted data files (5008293 lines) at:
     /home/k6-workdir/influxdb-metrics.log-split-nq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ub (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zams (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-or (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ld (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-an (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaaq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaik (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaft (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ja (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zang (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaao (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ed (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-et (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaje (5000)
     /home/k6-workdir/influxdb-metrics.log-split-eq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaaz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaex (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaga (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-di (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-la (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ud (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ae (5000)
     /home/k6-workdir/influxdb-metrics.log-split-me (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zail (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ht (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zanh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ef (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaij (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-al (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-no (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-iw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ay (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-av (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ls (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-op (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ps (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-os (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaia (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaha (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-im (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-as (5000)
     /home/k6-workdir/influxdb-metrics.log-split-om (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-na (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-so (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zago (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ke (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ym (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaer (5000)
     /home/k6-workdir/influxdb-metrics.log-split-on (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaii (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-de (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaef (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaew (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaac (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaee (5000)
     /home/k6-workdir/influxdb-metrics.log-split-li (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ak (5000)
     /home/k6-workdir/influxdb-metrics.log-split-iz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ci (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaiv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ve (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-en (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ev (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaez (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-px (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-il (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zach (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaco (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ii (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaah (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ws (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ga (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaln (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zana (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaio (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaib (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaif (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zake (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ng (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zack (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ge (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ca (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-go (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ry (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ax (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ny (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zanl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zace (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafe (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ko (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ue (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zama (5000)
     /home/k6-workdir/influxdb-metrics.log-split-up (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ig (5000)
     /home/k6-workdir/influxdb-metrics.log-split-py (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ho (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zade (5000)
     /home/k6-workdir/influxdb-metrics.log-split-he (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaab (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-io (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-js (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zady (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ji (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaiu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaax (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ej (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-eg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaby (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-td (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ly (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ok (5000)
     /home/k6-workdir/influxdb-metrics.log-split-if (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ug (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-us (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ih (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ek (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-in (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ee (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ph (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ot (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ni (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zanm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ki (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zage (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ln (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zado (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaku (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaai (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaaw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ts (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ra (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-po (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ce (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fe (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ds (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaju (5000)
     /home/k6-workdir/influxdb-metrics.log-split-we (5000)
     /home/k6-workdir/influxdb-metrics.log-split-at (5000)
     /home/k6-workdir/influxdb-metrics.log-split-st (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaeb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaja (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaej (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ss (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-th (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaml (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ty (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ql (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaca (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ob (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaas (5000)
     /home/k6-workdir/influxdb-metrics.log-split-re (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaap (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zanc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaih (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ei (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ic (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaeh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-es (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zald (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ti (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaig (5000)
     /home/k6-workdir/influxdb-metrics.log-split-is (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-br (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-se (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-su (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ff (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaic (5000)
     /home/k6-workdir/influxdb-metrics.log-split-eu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qe (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaei (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ip (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaiw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaen (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-er (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaba (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ex (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-id (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaim (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ou (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaiq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ka (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-by (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ba (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaay (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zair (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ch (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ml (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ib (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ul (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ij (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xe (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaeg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ye (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-aq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaet (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ez (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ew (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaeq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaav (5000)
     /home/k6-workdir/influxdb-metrics.log-split-aj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-am (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaid (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zako (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-of (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaky (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zada (5000)
     /home/k6-workdir/influxdb-metrics.log-split-od (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zala (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-te (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaaj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaau (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-da (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zads (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ik (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-um (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaem (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaed (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaec (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ys (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaci (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-af (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ha (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaey (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ir (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ar (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ua (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zale (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ah (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zais (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zall (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaff (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-eo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaiy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-un (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zane (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-it (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-je (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ai (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ix (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ne (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zael (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zanj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaaf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ur (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-si (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zanf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zand (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ow (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ux (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-au (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zait (5000)
     /home/k6-workdir/influxdb-metrics.log-split-np (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-be (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ku (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-du (5000)
     /home/k6-workdir/influxdb-metrics.log-split-co (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaip (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pe (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaaa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ct (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ut (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ec (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaam (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ck (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaan (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ro (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaat (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-my (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ma (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaly (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaep (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaev (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-to (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zann (3293)
     /home/k6-workdir/influxdb-metrics.log-split-fi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ac (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-df (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-aw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ui (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaeo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabe (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-do (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaae (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ea (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zank (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ru (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ad (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ll (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ov (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ox (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaji (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaal (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zani (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ep (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-eh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaiz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ey (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-uu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaka (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ab (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaix (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ag (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ya (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaki (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-db (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaks (5000)
     /home/k6-workdir/influxdb-metrics.log-split-iq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-xg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaho (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-og (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaht (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ks (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ww (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-iy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zami (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ft (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-km (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ia (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaar (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ol (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-md (5000)
     /home/k6-workdir/influxdb-metrics.log-split-aa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ju (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zali (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ta (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ky (5000)
     /home/k6-workdir/influxdb-metrics.log-split-hs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zals (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaad (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-el (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ie (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaag (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zadb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-eb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zame (5000)
     /home/k6-workdir/influxdb-metrics.log-split-va (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zain (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaak (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-tp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaes (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zags (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ap (5000)
     /home/k6-workdir/influxdb-metrics.log-split-oe (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ms (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaea (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zabi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-mz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zacz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ao (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zafk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zagc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zanb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-iu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaie (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahe (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-em (5000)
     /home/k6-workdir/influxdb-metrics.log-split-vi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-az (5000)
     /home/k6-workdir/influxdb-metrics.log-split-sd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-lm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zahg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ns (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zajw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaek (5000)
     /home/k6-workdir/influxdb-metrics.log-split-kt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-wq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-fu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-rj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-jg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-qu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zakw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-iv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ri (5000)
     /home/k6-workdir/influxdb-metrics.log-split-nw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zact (5000)
     /home/k6-workdir/influxdb-metrics.log-split-le (5000)
     /home/k6-workdir/influxdb-metrics.log-split-pg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zalp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-gk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zamf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-zaeu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-yd (5000)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ab
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ac
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ad
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ae
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-af
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ag
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ah
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ai
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ak
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-al
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-am
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-an
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ao
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ap
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ar
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-as
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-at
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-au
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-av
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ax
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ay
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-az
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ba
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-be
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-br
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-by
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ca
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ce
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ch
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ci
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ck
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-co
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ct
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-da
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-db
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-de
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-df
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-di
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-do
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ds
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-du
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ea
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ec
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ed
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ee
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ef
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ei
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ej
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ek
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-el
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-em
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-en
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ep
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-er
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-es
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-et
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ev
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ew
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ex
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ey
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ez
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fe
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ff
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ft
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ga
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ge
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-go
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ha
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-he
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ho
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ht
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ia
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ib
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ic
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-id
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ie
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-if
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ig
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ih
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ii
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ij
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ik
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-il
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-im
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-in
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-io
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ip
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ir
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-is
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-it
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ix
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ja
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-je
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ji
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-js
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ju
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ka
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ke
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ki
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-km
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ko
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ks
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ku
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ky
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-la
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ld
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-le
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-li
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ll
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ln
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ls
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ly
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ma
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-md
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-me
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ml
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ms
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-my
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-na
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ne
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ng
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ni
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-no
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-np
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ns
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ny
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ob
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-od
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oe
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-of
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-og
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ok
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ol
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-om
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-on
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-op
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-or
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-os
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ot
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ou
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ov
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ow
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ox
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pe
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ph
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-po
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ps
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-px
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-py
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qe
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ql
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ra
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-re
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ri
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ro
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ru
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ry
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-se
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-si
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-so
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ss
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-st
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-su
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ta
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-td
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-te
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-th
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ti
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-to
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ts
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ty
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-tz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ua
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ub
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ud
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ug
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ui
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ul
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-um
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-un
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-up
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ur
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-us
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ut
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ux
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-uz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-va
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ve
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-vz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-we
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ws
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ww
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-wz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xe
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-xz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ya
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ye
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ym
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ys
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-yz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaaa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaab
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaac
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaad
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaae
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaaf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaag
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaah
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaai
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaaj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaak
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaal
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaam
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaan
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaao
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaap
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaaq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaar
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaas
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaat
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaau
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaav
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaaw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaax
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaay
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaaz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaba
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabe
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaby
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zabz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaca
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zace
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zach
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaci
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zack
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaco
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zact
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zacz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zada
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zade
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zado
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zads
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zady
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zadz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaea
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaeb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaec
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaed
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaee
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaef
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaeg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaeh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaei
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaej
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaek
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zael
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaem
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaen
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaeo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaep
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaeq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaer
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaes
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaet
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaeu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaev
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaew
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaex
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaey
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaez
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafe
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaff
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaft
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zafz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaga
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zage
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zago
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zags
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zagz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaha
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahe
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaho
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaht
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zahz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaia
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaib
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaic
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaid
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaie
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaif
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaig
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaih
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaii
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaij
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaik
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zail
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaim
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zain
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaio
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaip
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaiq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zair
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zais
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zait
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaiu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaiv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaiw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaix
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaiy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaiz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaja
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaje
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaji
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaju
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zajz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaka
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zake
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaki
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zako
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaks
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaku
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaky
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zakz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zala
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zald
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zale
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zali
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zall
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaln
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zals
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaly
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zalz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zama
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zame
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zami
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zaml
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zams
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zamz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zana
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zanb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zanc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zand
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zane
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zanf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zang
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zanh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zani
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zanj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zank
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zanl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zanm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-zann   
```