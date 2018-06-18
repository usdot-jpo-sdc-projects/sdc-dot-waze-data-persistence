
--------------------------------------------------------------------
--Update Batch Id
--------------------------------------------------------------------
update dw_waze.stage_jam_point_sequence_{{ batchIdValue }}  set etl_run_id={{ batchIdValue }} ;

----------------------------------------------------
--ETL Load
----------------------------------------------------

INSERT INTO dw_waze.jam_point_sequence
select sjps.jam_id 
	,sjps.location_x 
	,sjps.location_y 
	,sjps.sequence_order
from dw_waze.stage_jam_point_sequence_{{ batchIdValue }} sjps
left join dw_waze.jam_point_sequence jps on 
jps.jam_id=sjps.jam_id
AND jps.location_x=sjps.location_x
AND jps.location_y=sjps.location_y
AND jps.sequence_order=sjps.sequence_order
where jps.jam_id  is null
GROUP BY sjps.jam_id 
	,sjps.location_x 
	,sjps.location_y 
	,sjps.sequence_order;

commit;