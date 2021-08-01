---
title: OSS monitoring series 
author: itgaiden
type: draft
date: 2021-07-27T11:27:51+00:00
url: oss-monitoring-series
categories:
  - microservices
tags:
  - monitoring

---
# OSS monitoring series 

## Context

If you work with micro-services (maybe not) and in the cloud (or not), you have probably heard about the many products for monitoring (or monitoring stacks), the most "modern" and famous OSS are:

- *ELK stack* (Elasticsearch, Logstash, and Kibana)
- *Grafana stack* (Grafana, Loki and Prometheus)

All these products are open-source projects which have become the go-to for many companies and I can deny that they work well (at least in my experience) especially for services built in the cloud or micro-services.

![image info](../static/oss-m-series-1.png)


Of course I can't forget other open source projects like Zabbix or Nagios but those are ones which I haven't seen to escalate as good as these ones, being versatile or being used as much as the ones I mentioned before.

There are other products like Splunk, Dynatrace, Datadog, etc. to talk about but I am aiming for those two stacks in particular (ELK and Grafana) as they are well known, accessible and open source.

## Series purpose

In this particular post I want to give a general overview for each tool within each stack but in the next ones I will give instructions about how to install, configure and useful features of both.

I hope this can guide new people or even discover new items for each tool.


## Wait, why monitoring?

Well, there are some points that we should take in to account but in a brief summary:

- **Alerting**: This is the most important ones, we want to know if something is broken and needs assistance to be fixed
 
- **Analyze trends** (long and short ones): Maybe you would like to analyze the growth of a DB or simply want to know how many HTTP requests are handling your servers to 

-  **Debugging** : Correlate events at the same time can be extremely helpful for incidents

So with those in mind, we can build dashboards and have beatiful graphs, logs and so which is going to be key for

## Basics



## ELK stack

ELK stands for Elasticsearch, Logstash, and Kibana as you probably have guessed.



## Grafana stack



Reference:
https://sre.google/sre-book/monitoring-distributed-systems/
https://www.moogsoft.com/blog/observability-site-reliability-engineers/