From: Szapar-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>
Date: Sat, 26 Mar 2022 12:40:48 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next] ice: Add support for
 double vlan in switchdev
In-Reply-To: <06caaa26-d0ae-989d-d55f-6535ba30a117@intel.com>
References: <20220325102922.3320-1-martyna.szapar-mudlaw@intel.com>
 <06caaa26-d0ae-989d-d55f-6535ba30a117@intel.com>
Message-ID: <DM6PR11MB426896E5EA49880819851D19BD1B9@DM6PR11MB4268.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Anthony,

I sent fixed v3 version.

Thanks,
Martyna

-----Original Message-----
From: Nguyen, Anthony L <anthony.l.nguyen@intel.com> 
Sent: 25 marca 2022 21:37
To: Szapar-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Wiktor Pilarczyk <wiktor.pilarczyk@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 net-next] ice: Add support for double vlan in switchdev


On 3/25/2022 3:29 AM, Martyna Szapar-Mudlaw wrote:+
>   static const struct ice_dummy_pkt_profile ice_dummy_pkt_profiles[] = {
> +	ICE_PKT_PROFILE(qinq_ipv6_tcp, ICE_PKT_CVLAN |
> +				       ICE_PKT_VLAN |
> +				       ICE_PKT_OUTER_IPV6 |
> +				       ICE_PKT_INNER_TCP),
> +	ICE_PKT_PROFILE(qinq_ipv6_udp, ICE_PKT_CVLAN |
> +				       ICE_PKT_VLAN |
> +				       ICE_PKT_OUTER_IPV6 |
> +				       ICE_PKT_INNER_UDP),
> +	ICE_PKT_PROFILE(qinq_ipv6, ICE_PKT_CVLAN |
> +			           ICE_PKT_VLAN |
> +				   ICE_PKT_OUTER_IPV6),

There's a spacing issue here:

ERROR: code indent should use tabs where possible
#261: FILE: drivers/net/ethernet/intel/ice/ice_switch.c:1446:
+^I^I^I?????????? ICE_PKT_VLAN |$

