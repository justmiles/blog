title: CloudWatch Graphs from CLI
tags:
---

    function cloudwatch {
      aws cloudwatch get-metric-widget-image --metric-widget "$1" | jq -r '.MetricWidgetImage' | base64 -d > img.png
    }


    cloudwatch '{
        "metrics": [
            [ "AWS/ElastiCache", "CurrConnections", "CacheClusterId", "qa-cll-ampre-local" ]
        ],
        "view": "timeSeries",
        "stacked": false,
        "width": 1670,
        "height": 250,
        "start": "-P7D",
        "end": "P0D"
    }'

    xdg-open img.png 