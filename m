From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 18 Mar 2022 13:23:21 -0700
Subject: [Intel-wired-lan] [PATCH v3 net-next 3/5] ice: switch: use a
 struct to pass packet template params
In-Reply-To: <20220318161713.680436-4-alexandr.lobakin@intel.com>
References: <20220318161713.680436-1-alexandr.lobakin@intel.com>
 <20220318161713.680436-4-alexandr.lobakin@intel.com>
Message-ID: <6fab3fee-5177-4bc6-c8c1-355d5803441a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 3/18/2022 9:17 AM, Alexander Lobakin wrote:
> ice_find_dummy_packet() contains a lot of boilerplate code and a
> nice room for copy-paste mistakes.
> Instead of passing 3 separate pointers back and forth to get packet
> template (dummy) params, directly return a structure containing
> them. Then, use a macro to compose compound literals and avoid code
> duplication on return path.
> Now, dummy packet type/name is needed only once to return a full
> correct triple pkt-pkt_len-offsets, and those are all one-liners.
> dummy_ipv4_gtpu_ipv4_packet_offsets is just moved around and renamed
> (as well as dummy_ipv6_gtp_packet_offsets) with no function changes.

Looks like there are 32 bit build issues for this patch[1]:


../drivers/net/ethernet/intel/ice/ice_switch.c:5638:16: warning: invalid 
access past the end of '<noident>' (8 12)
../drivers/net/ethernet/intel/ice/ice_switch.c:5636:24: warning: invalid 
access past the end of '<noident>' (8 12)
../drivers/net/ethernet/intel/ice/ice_switch.c:5632:32: warning: invalid 
access past the end of '<noident>' (8 12)
../drivers/net/ethernet/intel/ice/ice_switch.c:5630:32: warning: invalid 
access past the end of '<noident>' (8 12)
../drivers/net/ethernet/intel/ice/ice_switch.c:5627:32: warning: invalid 
access past the end of '<noident>' (8 12)
../drivers/net/ethernet/intel/ice/ice_switch.c:5625:32: warning: invalid 
access past the end of '<noident>' (8 12)
...

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/20220318161713.680436-4-alexandr.lobakin at intel.com/

