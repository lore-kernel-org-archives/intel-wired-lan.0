From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Wed, 15 Apr 2015 08:07:55 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Set rx hash type for ingress
	packets
In-Reply-To: <5A90DA2E42F8AE43BC4A093BF0678848E41E50@SHSMSX104.ccr.corp.intel.com>
References: <87618083B2453E4A8714035B62D6799250295BAB@FMSMSX105.amr.corp.intel.com>
 <1429067542-20845-1-git-send-email-fan.du@intel.com>
 <87618083B2453E4A8714035B62D6799250295D66@FMSMSX105.amr.corp.intel.com>
 <5A90DA2E42F8AE43BC4A093BF0678848E41E50@SHSMSX104.ccr.corp.intel.com>
Message-ID: <87618083B2453E4A8714035B62D6799250296E4A@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Du, Fan 
>Sent: Wednesday, April 15, 2015 12:28 AM
>Subject: RE: [PATCH] ixgbevf: Set rx hash type for ingress packets
>
>
>
>>-----Original Message-----
>>From: Tantilov, Emil S
>>Sent: Wednesday, April 15, 2015 11:42 AM
>>To: Du, Fan; Kirsher, Jeffrey T
>>Cc: intel-wired-lan at lists.osuosl.org; e1000-devel at lists.sourceforge.net;
>>fengyuleidian0615 at gmail.com
>>Subject: RE: [PATCH] ixgbevf: Set rx hash type for ingress packets
>>
>>>-----Original Message-----
>>>From: Du, Fan
>>>Sent: Tuesday, April 14, 2015 8:12 PM
>>>To: Kirsher, Jeffrey T
>>>Subject: [PATCH] ixgbevf: Set rx hash type for ingress packets
>>>
>>>Set hash type for ingress packets according to NIC
>>>advanced receive descriptors RSS type part.
>>>
>>>also use le16_to_cpu forcing type conversion to slient
>>>endian check warnings.
>>>
>>>Signed-off-by: Fan Du <fan.du@intel.com>
>>>---
>>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |    2 +-
>>> drivers/net/ethernet/intel/ixgbevf/defines.h      |   12 ++++++++
>>> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   30
>>+++++++++++++++++++++
>>> 3 files changed, 43 insertions(+), 1 deletions(-)
>>>
>>>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>index 8915992..1b3b5fb 100644
>>>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>@@ -1359,7 +1359,7 @@ static int __ixgbe_notify_dca(struct device *dev,
>>void *data)
>>> #endif /* CONFIG_IXGBE_DCA */
>>> static inline enum pkt_hash_types ixgbe_get_hash_type(__le16 pkt_info)
>>> {
>>>-	switch (pkt_info & cpu_to_le16(IXGBE_RXDADV_RSSTYPE_MASK)) {
>>>+	switch (le16_to_cpu(pkt_info) & IXGBE_RXDADV_RSSTYPE_MASK) {
>>
>>This appears to be a fix for your ixgbe patch and does not belong here. The
>>proper way to handle it is to submit
>>version 2.
>
>ok, I will send v2 for ixgbe patch, but Jeffrey has to drop previous ixgbe path he has queued.
>
>>Also checkout my reply to your ixgbe patch - it has the logic we use in
>>ixgbe and there are some differences
>>that we need to address before we can accept this. Like the IPV4/6 extensions
>>defines are not included
>
>All RSSTYPE suffixed with '_EX' are marked as reserved, which hold no valid meaning
>from 82599 data sheet labeled February 2015 Revision 3.1 331520-002.
>
>Is there any other official document states what does those bits mean?

They are defined, so they do probably have meaning, although you're right that it is not in the datasheet.
I'll have to check.

>>and in the case of rss_type being 0 RSS is nor performed
>>and so we probably should not call set_skb_hash() in that situation.
>
>Hmm, this relies on the fact skb hash parts are cleared at the allocation of skb structure.
>yes we should not set hash for PKT_HASH_TYPE_NONE, however bnx2x/i40e all call set_skb_hash
>to clear skb hash parts for PKT_HASH_TYPE_NONE as a defensive programming probably.
>I'm ok with either way, I will fix this part if you insist to do so.
>which would you prefer?

I'd rather we keep the logic we use in the out of tree driver (see my other email).

Thanks,
Emil

