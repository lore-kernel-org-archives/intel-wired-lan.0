From: Benjamin Poirier <bpoirier@suse.com>
Date: Wed, 28 Feb 2018 14:19:12 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Fix link check race
 condition.
In-Reply-To: <CAKgT0Ueyz9LPz4UwYVpgZJ+nW2YV2A-mYqUQbBP2RaDfgH91rA@mail.gmail.com>
References: <CAKgT0UffXiggXxC5x1vrtbnKPHzcy8+VTRvBGBH-7tCYmUi6LQ@mail.gmail.com>
 <20180226023118.17439-1-bpoirier@suse.com>
 <CAKgT0Ueyz9LPz4UwYVpgZJ+nW2YV2A-mYqUQbBP2RaDfgH91rA@mail.gmail.com>
Message-ID: <20180228051912.cueusc3wn44ksdc3@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/02/26 08:14, Alexander Duyck wrote:
[...]
> 
> >
> >         switch (hw->mac.type) {
> >         case e1000_pch2lan:
> >                 ret_val = e1000_k1_workaround_lv(hw);
> >                 if (ret_val)
> > -                       return ret_val;
> > +                       goto out;
> >                 /* fall-thru */
> >         case e1000_pchlan:
> >                 if (hw->phy.type == e1000_phy_82578) {
> >                         ret_val = e1000_link_stall_workaround_hv(hw);
> >                         if (ret_val)
> > -                               return ret_val;
> > +                               goto out;
> >                 }
> >
> >                 /* Workaround for PCHx parts in half-duplex:
> > @@ -1595,7 +1596,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
> >         if (hw->phy.type > e1000_phy_82579) {
> >                 ret_val = e1000_set_eee_pchlan(hw);
> >                 if (ret_val)
> > -                       return ret_val;
> > +                       goto out;
> >         }
> >
> >         /* If we are forcing speed/duplex, then we simply return since
> > @@ -1618,10 +1619,14 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
> >         ret_val = e1000e_config_fc_after_link_up(hw);
> >         if (ret_val) {
> >                 e_dbg("Error configuring flow control\n");
> > -               return ret_val;
> > +               goto out;
> >         }
> 
> Technically these changes would be a change in behavior. For these we
> may just want to leave them as-is since I am not certain they would
> have any actual impact on the link state other than delaying the
> link-up. For example do we really care if we fail to negotiate flow
> control? We may not so we might report link up and just a debug
> message indicating we didn't negotiate that part of the link.

You're right and actually that raises yet another problem with commit
19110cfbb34d ("e1000e: Separate signaling for link check/link up").

Previously these errors which come after the "get_link_status = false"
would be ignored and the link considered up. After that commit, any
error implies that the link is down:

-			link_active = !hw->mac.get_link_status;
+			link_active = ret_val > 0;

I'll send a patch to fix that problem first and then get back to this
race.
