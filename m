From: Greg KH <greg@kroah.com>
Date: Sun, 14 Jan 2018 09:23:16 +0100
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix
 e1000_check_for_copper_link_ich8lan return value.
In-Reply-To: <20180110013443.xrmta4kcq7yy2olz@f1.synalogic.ca>
References: <af44aaff-53e6-fb00-2dd6-d47396e56beb@gmx.de>
 <20180110013443.xrmta4kcq7yy2olz@f1.synalogic.ca>
Message-ID: <20180114082316.GA15969@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 10, 2018 at 10:34:43AM +0900, Benjamin Poirier wrote:
> On 2018/01/10 01:29, rwarsow at gmx.de wrote:
> > hallo
> > 
> > any chance to get this patch into stable and 4.15 ?
> > 
> > https://marc.info/?l=linux-kernel&m=151297726823919&w=2
> > 
> 
> It was part of the last network pull request and should be included in
> the next mainline release as
> 4110e02eb45e e1000e: Fix e1000_check_for_copper_link_ich8lan return value.
> 
> It's needed in stable branches that include commit 19110cfbb34d
> ("e1000e: Separate signaling for link check/link up"):
> 	linux-4.14.y
> 	linux-4.9.y
> 	linux-4.4.y
> 	linux-4.1.y
> 	linux-3.18.y

Now queued up, thanks!

greg k-h
