From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jan 2022 21:39:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next 3/4] ice: switch: use a
 struct to pass packet template params
In-Reply-To: <20220124173116.739083-4-alexandr.lobakin@intel.com>
References: <20220124173116.739083-1-alexandr.lobakin@intel.com>
 <20220124173116.739083-4-alexandr.lobakin@intel.com>
Message-ID: <6375d82b976f18eb085859082c548b35b168cf14.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2022-01-24 at 18:31 +0100, Alexander Lobakin wrote:
> ice_find_dummy_packet() contains a lot of boilerplate code and a
> nice room for copy-paste mistakes.
> Instead of passing 3 separate pointers back and forth to get packet
> template (dummy) params, directly return a structure containing
> them. Then, use a macro to compose compound literals and avoid code
> duplication on return path.
> Now, dummy packet type/name is needed only once to return a full
> correct triple pkt-pkt_len-offsets, and those are all one-liners.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

This isn't applying to next-queue.

<snip>
> @@ -4960,11 +4974,9 @@ ice_add_adv_recipe(struct ice_hw *hw, struct
> ice_adv_lkup_elem *lkups,
> ? * @pkt_len: packet length of dummy packet
> ? * @offsets: pointer to receive the pointer to the offsets for the
> packet
> ? */
> -static void
> +static struct ice_dummy_pkt_profile
> ?ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16
> lkups_cnt,
> -???????????????????? enum ice_sw_tunnel_type tun_type,
> -???????????????????? const u8 **pkt, u16 *pkt_len,
> -???????????????????? const struct ice_dummy_pkt_offsets **offsets)
> +???????????????????? enum ice_sw_tunnel_type tun_type)

kdoc needs to be updated here.

<snip>

> ?/**
> @@ -5104,8 +5065,7 @@ ice_find_dummy_packet(struct ice_adv_lkup_elem
> *lkups, u16 lkups_cnt,
> ?static int
> ?ice_fill_adv_dummy_packet(struct ice_adv_lkup_elem *lkups, u16
> lkups_cnt,
> ????????????????????????? struct ice_aqc_sw_rules_elem *s_rule,
> -???????????????????????? const u8 *dummy_pkt, u16 pkt_len,
> -???????????????????????? const struct ice_dummy_pkt_offsets
> *offsets)
> +???????????????????????? const struct ice_dummy_pkt_profile
> *profile)

Here as well.

Thanks,
Tony
