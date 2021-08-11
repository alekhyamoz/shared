INSERT INTO `moz-fx-data-shared-prod.telemetry_derived.clients_histogram_aggregates_v2`
    (submission_date ,
    sample_id ,
    client_id ,
    os ,
    app_version,
    app_build_id,
    histogram_aggregates
    )
SELECT
   submission_date ,
    sample_id ,
    client_id ,
    os ,
    app_version,
    app_build_id,
  ARRAY_AGG(STRUCT(a1.first_bucket,
      a1.last_bucket ,
      a1.num_buckets ,
      a1.metric ,
      a1.metric_type ,
      a1.key ,
      a1.process ,
      a1.agg_type ,
      a1.aggregates ))AS histogram_aggregates
FROM
  `moz-fx-data-shared-prod.telemetry_derived.clients_histogram_aggregates_v1`,
  UNNEST(histogram_aggregates) AS a1
where submission_date = '2021-08-04' and sample_id = 0
GROUP BY
  submission_date ,
    sample_id ,
    client_id ,
    os ,
    app_version,
    app_build_id
