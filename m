From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 17 May 2016 01:45:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of
 RX	network flow classification
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81EFDB5D@ORSMSX101.amr.corp.intel.com>
References: <1462786062-7572-1-git-send-email-gangfeng.huang@ni.com>
 <1462786062-7572-2-git-send-email-gangfeng.huang@ni.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81EFDB5D@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EFDCCB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Brown, Aaron F
> Sent: Monday, May 16, 2016 3:09 PM
> To: Gangfeng <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org
> Cc: Ruhao Gao <ruhao.gao@ni.com>
> Subject: Re: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of RX
> network flow classification
> 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> > Behalf Of Gangfeng
> > Sent: Monday, May 9, 2016 2:28 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Gangfeng Huang <gangfeng.huang@ni.com>; Ruhao Gao
> > <ruhao.gao@ni.com>
> > Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of RX
> > network flow classification
> >
> > From: Gangfeng Huang <gangfeng.huang@ni.com>
> >
> > This patch is meant to allow for RX network flow classification to insert
> > and remove Rx filter by ethtool. Ethtool interface has it's own rules
> > manager
> >
> > Show all filters:
> > $ ethtool -n eth0
> > 4 RX rings available
> > Total 2 rules
> >
> > Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> > Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb.h         |  32 +++++
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c | 193
> > +++++++++++++++++++++++++++
> >  drivers/net/ethernet/intel/igb/igb_main.c    |  44 ++++++
> >  3 files changed, 269 insertions(+)
> 
> This patch is causing 3/4 of my regression systems to fail.  Driver load seems
> normal, but applying an IP address via ifconfig causes the following splat in

<snip>

> The system will then seem to function normally for a few minutes more then,
> even if left completely idle, will spew out another splat and the console
> freezes.  A few more minutes and another splat hits the screen, but he
> console is otherwise still locked up.  These later splats do not get captured to
> the logs.

This second set of splats is not related to this patch or the series.  Only the splat that follows address binding seems to be caused by this patch.  A later series of patches for igb ptp seems to be the culprit for the delayed freeze trace.

