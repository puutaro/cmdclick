#!/bin/bash

lecho(){
	if [ ${CMDCLICK_LOG_ON} -eq 1 ];then echo "${1}"; fi
}

sckash_sinbol(){
	echo "${1}" | sed 's/[\]//g' | sed 's/'${CMDCLICK_BACKSLASH_MARK}'//g' | sed 's|'${CMD_CLICK_VIRTICAL_VAR}'||g'  | sed 's|[|]||g'  | sed 's/'${CMDCLICK_ANPASAD}'//g' | sed 's/'${CMDCLICK_XTRAMATION}'//g' | sed 's/'${CMDCLICK_DOUBLEQUOTE}'//g' | sed "s/${CMDCLICK_SINGLEQUOTE}//g" | sed "s/${CMDCLICK_BACKQUOTE}//g" | sed 's/'${CMDCLICK_EQUALE}'//g' | sed 's/'${CMDCLICK_HATHAT}'//g'  | sed "s/${CMDCLICK_DAIKAKKO_MAE}//g"  | sed "s/${CMDCLICK_DAIKAKKO_ATO}//g"  | sed "s/${CMDCLICK_KAGIKAKKO_MAE}//g"  | sed "s/${CMDCLICK_KAGIKAKKO_ATO}//g"  | sed "s/${CMDCLICKKAKEZAN_MARK}//g" | sed "s/${CMDCLICK_DOLL_MARK}//g" | sed "s/${CMDCLICK_PLUS_MARK}//g" | sed "s/${CMDCLICK_HATENA_MARK}//g" | sed "s/${CMDCLICK_SEED_MARK}//g" | sed "s/${CMDCLICK_BACKSEED_MARK}//g" | sed "s/${CMDCLICK_COLON_MARK}//g" | sed "s/${CMDCLICK_COLONNAO_MARK}//g" | sed "s/${CMDCLICK_ATTO_MARK}//g" | sed "s/${CMDCLICK_NYORONYORO_MARK}//g" | sed "s/${CMDCLICK_HUTUUKAKKO_MAE_MARK}//g" | sed "s/${CMDCLICK_HUTUUKAKKO_ATO_MARK}//g" | sed "s/${CMDCLICK_PERCENT_ATO_MARK}//g" | sed "s/${CMDCLICK_SHARP_MARK}//g" | sed "s/${CMDCLICK_SLASH_MARK}//g"
}