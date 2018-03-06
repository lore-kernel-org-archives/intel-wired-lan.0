From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Mar 2018 06:53:59 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: Fix link check race
 condition
In-Reply-To: <20180306015553.10441-2-bpoirier@suse.com>
References: <20180306015553.10441-1-bpoirier@suse.com>
 <20180306015553.10441-2-bpoirier@suse.com>
Message-ID: <CAKgT0UfVVA43gbEQSyJ3XithVun6UST+_-b-=tQiCugU=PPzfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 5, 2018 at 5:55 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> Alex reported the following race condition:
>
> /* link goes up... interrupt... schedule watchdog */
> \ e1000_watchdog_task
>         \ e1000e_has_link
>                 \ hw->mac.ops.check_for_link() === e1000e_check_for_copper_link
>                         \ e1000e_phy_has_link_generic(..., &link)
>                                 link = true
>
>                                          /* link goes down... interrupt */
>                                          \ e1000_msix_other
>                                                  hw->mac.get_link_status = true
>
>                         /* link is up */
>                         mac->get_link_status = false
>
>                 link_active = true
>                 /* link_active is true, wrongly, and stays so because
>                  * get_link_status is false */
>
> Avoid this problem by making sure that we don't set get_link_status = false
> after having checked the link.
>
> It seems this problem has been present since the introduction of e1000e.
>
> Link: https://lkml.org/lkml/2018/1/29/338
> Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Looks good. Thanks.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
