From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Fri, 04 Sep 2015 11:35:48 +0200
Subject: [Intel-wired-lan] minor oddity in
	drivers/net/ethernet/intel/i40e/i40e_main.c
Message-ID: <87fv2ucyrv.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I just noticed a slightly odd thing - it may be harmless, but thought
I'd mention it anyway:


   1743                 del_list = kcalloc(filter_list_len,
   1744                             sizeof(struct i40e_aqc_remove_macvlan_element_data),
   1745                             GFP_KERNEL);

   1772                         /* flush a full buffer */
   1773                         if (num_del == filter_list_len) {
   1774                                 aq_ret = i40e_aq_remove_macvlan(&pf->hw,
   1775                                             vsi->seid, del_list, num_del,
   1776                                             NULL);
   1777                                 num_del = 0;
   1778                                 memset(del_list, 0, sizeof(*del_list));

On line 1743, we kcalloc an array (del_list) with filter_list_len
elements. When that's full, we handle what's in it and then reset
num_del. However, the memset on line 1778 only clears the first element
in the array, so we're not exactly in the same state as after the
kcalloc. But maybe filter_list_len is always so large that we never
actually hit this, or maybe it is always 1 (btw., what guarantees it is
not 0?)

The same issue (or non-issue :-)) applies to add_list a few lines further down.

Rasmus
