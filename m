From: Benjamin Poirier <bpoirier@suse.com>
Date: Mon, 29 Jan 2018 16:21:09 +0900
Subject: [Intel-wired-lan] [PATCH 2/3] Revert "e1000e: Separate
 signaling for link check/link up"
In-Reply-To: <CAKgT0UegBcVf5vzc7Vq4E1RpeeR7gqCAD=1+wn1Yq_tL48+LaA@mail.gmail.com>
References: <20180126091236.13044-1-bpoirier@suse.com>
 <20180126091236.13044-3-bpoirier@suse.com>
 <CAKgT0UegBcVf5vzc7Vq4E1RpeeR7gqCAD=1+wn1Yq_tL48+LaA@mail.gmail.com>
Message-ID: <20180129072109.2jo5fe4ujozp3ykk@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/26 09:03, Alexander Duyck wrote:
> On Fri, Jan 26, 2018 at 1:12 AM, Benjamin Poirier <bpoirier@suse.com> wrote:
> > This reverts commit 19110cfbb34d4af0cdfe14cd243f3b09dc95b013.
> > This reverts commit 4110e02eb45ea447ec6f5459c9934de0a273fb91.
> >
> > ... because they cause an extra 2s delay for the link to come up when
> > autoneg is off.
> >
> > After reverting, the race condition described in the log of commit
> > 19110cfbb34d ("e1000e: Separate signaling for link check/link up") is
> > reintroduced. It may still be triggered by LSC events but this should not
> > result in link flap. It may no longer be triggered by RXO events because
> > commit 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> > restored reading icr in the Other handler.
> 
> With the RXO events removed the only cause for us to transition the
> bit should be LSC. I'm not sure if the race condition in that state is
> a valid concern or not as the LSC should only get triggered if the
> link state toggled, even briefly.
> 
> The bigger concern I would have would be the opposite of the original
> race that was pointed out:
>     \ e1000_watchdog_task
>         \ e1000e_has_link
>             \ hw->mac.ops.check_for_link() === e1000e_check_for_copper_link
>                 /* link is up */
>                 mac->get_link_status = false;
> 
>                                 /* interrupt */
>                                 \ e1000_msix_other
>                                     hw->mac.get_link_status = true;
> 
>             link_active = !hw->mac.get_link_status
>             /* link_active is false, wrongly */
> 
> So the question I would have is what if we see the LSC for a link down
> just after the check_for_copper_link call completes? It may not be

Can you write out exactly what that race would be, in a format similar to the
above?

> anything seen in the real world since I don't know if we have any link
> flapping issues on e1000e or not without this patch. It is something
> to keep in mind for the future though.
> 
> 
> > As discussed, the driver should be in "maintenance mode". In the interest
> > of stability, revert to the original code as much as possible instead of a
> > half-baked solution.
> 
> If nothing else we may want to do a follow-up on this patch as we
> probably shouldn't be returning the error values to trigger link up.
> There are definitely issues to be found here. If nothing else we may
> want to explore just returning 1 if auto-neg is disabled instead of
> returning an error code.
> 
> > Link: https://www.spinics.net/lists/netdev/msg479923.html
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
[...]
