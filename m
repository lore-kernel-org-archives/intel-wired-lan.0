From: Chris Arges <carges@vectranetworks.com>
Date: Mon, 17 Oct 2016 18:36:38 +0000
Subject: [Intel-wired-lan] Bug with 'igb: Remove GS40G specific
 defines/functions'
In-Reply-To: <1476444273.23813.23.camel@maxwell>
References: <77C85CBC-39FD-40B4-9456-56A3FEE3544A@vectranetworks.com>
 <1570773976.567827.1476303559656.JavaMail.zimbra@xes-inc.com>
 <20F028E5-EC20-4F65-8889-3F254196ABF8@vectranetworks.com>
 <133564642.602581.1476305193640.JavaMail.zimbra@xes-inc.com>
 <F267652D-6FE2-4808-BFE7-013510C5A733@vectranetworks.com>
 <1476349095.18484.15.camel@maxwell>
 <1749CC13-EEFE-4EEB-B74E-40B563D7230C@vectranetworks.com>
 <1476444273.23813.23.camel@maxwell>
Message-ID: <BA60E6BA-8852-4D31-856B-434449463644@vectranetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/14/16, 6:24 AM, "Jochen Henneberg" <jh@henneberg-systemdesign.com> wrote:

    On Do, 2016-10-13 at 13:56 +0000, Chris Arges wrote:
    > Jochen,
    > 
    > Thanks for this update. I tested this patch and it fixes my issue!
    > If there are no other ill effects from this patch perhaps it would be
    > a good
    > candidate for mainline and stable.
    
    The patch is hacky, it does neither use the phy-ops.write_reg() nor does
    it check for the correct chip before it applies the write.
    I will try to prepare a clean fix and send a patch.
    
    Regards
    -Jochen
    
What about something as follows? This fixes the issue for me.

diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index 5b54254..6d42dfe 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -77,6 +77,10 @@ s32 igb_get_phy_id(struct e1000_hw *hw)
        s32 ret_val = 0;
        u16 phy_id;

+       /* ensure phy page selection to fix misconfigured i210 */
+       if (hw->mac.type == e1000_i210)
+               phy->ops.write_reg(hw, I347AT4_PAGE_SELECT, 0);
+
        ret_val = phy->ops.read_reg(hw, PHY_ID1, &phy_id);
        if (ret_val)
                goto out;

    > 
    > --chris
    
    -- 
    Henneberg - Systemdesign
    Jochen Henneberg
    Loehnfeld 26
    21423 Winsen (Luhe)
    --
    Fon: +49 4174 668 773
    Mobile: +49 172 160 14 69
    Fax: +49 321 210 761 64
    www: www.henneberg-systemdesign.com
    
    
    
    

