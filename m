From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 14 Nov 2019 11:38:06 -0800
Subject: [Intel-wired-lan] [PATCH net 01/13] ptp: Validate requests to
 enable time stamping of external signals.
In-Reply-To: <02874ECE860811409154E81DA85FBB589698F67E@ORSMSX121.amr.corp.intel.com>
References: <20191114184507.18937-2-richardcochran@gmail.com>
 <02874ECE860811409154E81DA85FBB589698F67E@ORSMSX121.amr.corp.intel.com>
Message-ID: <20191114193806.GA19147@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 14, 2019 at 07:06:58PM +0000, Keller, Jacob E wrote:
> Just to confirm, these new ioctls haven't been around long enough to be concerned about this change?

The "2" ioctls are about to appear in v5.4, and so I want to get the
flag checking in before the release if possible.

Thanks,
Richard
