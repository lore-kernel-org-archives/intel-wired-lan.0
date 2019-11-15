From: David Miller <davem@davemloft.net>
Date: Fri, 15 Nov 2019 12:49:32 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH net 00/13] ptp: Validate the ancillary
 ioctl flags more carefully.
In-Reply-To: <20191114184507.18937-1-richardcochran@gmail.com>
References: <20191114184507.18937-1-richardcochran@gmail.com>
Message-ID: <20191115.124932.339187560742442216.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 14 Nov 2019 10:44:54 -0800

> The flags passed to the ioctls for periodic output signals and
> time stamping of external signals were never checked, and thus formed
> a useless ABI inadvertently.  More recently, a version 2 of the ioctls
> was introduced in order make the flags meaningful.  This series
> tightens up the checks on the new ioctl flags.
> 
> - Patch 1 ensures at least one edge flag is set for the new ioctl.
> - Patches 2-7 are Jacob's recent checks, picking up the tags.
> - Patch 8 introduces a "strict" flag for passing to the drivers when the
>   new ioctl is used.
> - Patches 9-12 implement the "strict" checking in the drivers.
> - Patch 13 extends the test program to exercise combinations of flags.

Series applied, thanks Richard.
