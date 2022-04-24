From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun, 24 Apr 2022 22:03:55 +0300
Subject: [Intel-wired-lan] [PATCH net-next v3 2/2] net: vxlan:
 vxlan_core.c: Add extack support to vxlan_fdb_delete
In-Reply-To: <06622e4c-b9a5-1c4f-2764-a72733000b4e@gmail.com>
References: <cover.1650800975.git.eng.alaamohamedsoliman.am@gmail.com>
 <0d09ad611bb78b9113491007955f2211f3a06e82.1650800975.git.eng.alaamohamedsoliman.am@gmail.com>
 <alpine.DEB.2.22.394.2204241813210.7691@hadrien>
 <06622e4c-b9a5-1c4f-2764-a72733000b4e@gmail.com>
Message-ID: <3b8c790d-9e90-d920-9580-8e736435f7f3@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 24/04/2022 21:52, Alaa Mohamed wrote:
> 
> On ???/??/???? ??:??, Julia Lawall wrote:
>>
>> On Sun, 24 Apr 2022, Alaa Mohamed wrote:
>>
>>> Add extack to vxlan_fdb_delete and vxlan_fdb_parse
>> It could be helpful to say more about what adding extack support involves.
>>
>>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
>>> ---
>>> changes in V2:
>>> ????- fix spelling vxlan_fdb_delete
>>> ????- add missing braces
>>> ????- edit error message
>>> ---
>>> changes in V3:
>>> ????fix errors reported by checkpatch.pl
>> But your changes would seem to also be introducing more checkpatch errors,
>> because the Linux kernel coding style puts a space before an { at the
>> start of an if branch.
> I ran checkpatch script before submitting this patch and got no error

This is what I got:
WARNING: suspect code indent for conditional statements (8, 24)
#366: FILE: drivers/net/vxlan/vxlan_core.c:1137:
 	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
[...]
+			NL_SET_ERR_MSG(extack, "DST, VNI, ifindex and port are mutually exclusive with NH_ID");

WARNING: line length of 111 exceeds 100 columns
#370: FILE: drivers/net/vxlan/vxlan_core.c:1139:
+			NL_SET_ERR_MSG(extack, "DST, VNI, ifindex and port are mutually exclusive with NH_ID");

ERROR: space required before the open brace '{'
#377: FILE: drivers/net/vxlan/vxlan_core.c:1145:
+		if (err){

ERROR: space required before the open brace '{'
#389: FILE: drivers/net/vxlan/vxlan_core.c:1164:
+		if (nla_len(tb[NDA_PORT]) != sizeof(__be16)){

ERROR: space required before the open brace '{'
#400: FILE: drivers/net/vxlan/vxlan_core.c:1174:
+		if (nla_len(tb[NDA_VNI]) != sizeof(u32)){

ERROR: space required before the open brace '{'
#411: FILE: drivers/net/vxlan/vxlan_core.c:1184:
+		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32)){

ERROR: space required before the open brace '{'
#423: FILE: drivers/net/vxlan/vxlan_core.c:1196:
+		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32)){

ERROR: space required before the open brace '{'
#430: FILE: drivers/net/vxlan/vxlan_core.c:1202:
+		if (!tdev){

ERROR: space required after that ',' (ctx:VxV)
#431: FILE: drivers/net/vxlan/vxlan_core.c:1203:
+			NL_SET_ERR_MSG(extack,"Device not found");



