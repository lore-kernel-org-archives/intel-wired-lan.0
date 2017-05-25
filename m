From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 May 2017 18:21:14 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix incorrect pf->flags
In-Reply-To: <4b4638a9-a995-de0a-cdcd-97c891e1b6b3@oracle.com>
References: <1495242112-14835-1-git-send-email-tushar.n.dave@oracle.com>
 <1495703624.49259.39.camel@intel.com>
 <4b4638a9-a995-de0a-cdcd-97c891e1b6b3@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA40F8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On 05/25/2017 02:13 AM, Jeff Kirsher wrote:
> > On Fri, 2017-05-19 at 18:01 -0700, Tushar Dave wrote:
> >> Fix bug introduced by 'commit 47994c119a36e ("i40e: remove
> >> hw_disabled_flags in favor of using separate flag bits")' that
> >> mistakenly wipes out pf->flags.
> >>
> >> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> >> ---
> >>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


