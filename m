From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 26 Feb 2018 11:30:51 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 5/8] igb: Add support for
 ethtool MAC address filters
In-Reply-To: <A3A9616A-04ED-4E50-B82B-58BDED43F975@gmail.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
 <20180224012036.5834-6-vinicius.gomes@intel.com>
 <A3A9616A-04ED-4E50-B82B-58BDED43F975@gmail.com>
Message-ID: <874lm3blas.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Florian Fainelli <f.fainelli@gmail.com> writes:

> On February 23, 2018 5:20:33 PM PST, Vinicius Costa Gomes <vinicius.gomes@intel.com> wrote:
>>This adds the capability of configuring the queue steering of arriving
>>packets based on their source and destination MAC addresses.
>>
>>In practical terms this adds support for the following use cases,
>>characterized by these examples:
>>
>>$ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
>>(this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
>>to the RX queue 0)
>>
>>$ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 action 3
>>(this will direct packets with destination address "44:44:44:44:44:44"
>>to the RX queue 3)
>>
>>Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>---
>
> [snip]
>
>>diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
>>b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>>index 143f0bb34e4d..d8686a0f5b5d 100644
>>--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
>>+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>>@@ -152,6 +152,9 @@ static const char
>>igb_priv_flags_strings[][ETH_GSTRING_LEN] = {
>> 
>> #define IGB_PRIV_FLAGS_STR_LEN ARRAY_SIZE(igb_priv_flags_strings)
>> 
>>+static const u8 broadcast_addr[ETH_ALEN] = {
>>+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
>
> This is already defined in an existing header, don't have it handy but
> likely etherdevice.h.

Yeah, I didn't find the address definition, but there's a helper to
build a broadcast address, which is just what I need. Thanks.

>
> -- 
> Florian


Cheers,
--
Vinicius
