From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 22 Jan 2018 21:26:01 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 00/10] Time based packet
 transmission
In-Reply-To: <20180123052327.sxr63h3wmva4fvm4@localhost>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180123052327.sxr63h3wmva4fvm4@localhost>
Message-ID: <20180123052601.oqrh3cnwfpoxmsdg@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 22, 2018 at 09:23:27PM -0800, Richard Cochran wrote:
> On Wed, Jan 17, 2018 at 03:06:11PM -0800, Jesus Sanchez-Palencia wrote:
> > First, a baseline test was ran for 10 minutes with the plain kernel only:
> > 
> > |                 | plain kernel @ 1ms |
> > |-----------------+--------------------+
> > | min (ns):       |    +4.820000e+02   |
> > | max (ns):       |    +9.999300e+05   |
> > | pk-pk:          |    +9.994480e+05   |
> 
> ...
> 
> > |                 |    tbs SW @ 1ms   |  tbs HW @ 1ms  | tbs HW @ 250 us |
> > |-----------------+-------------------+----------------+-----------------|
> > | min (ns):       |    +1.510000e+02  |  +4.420000e+02 |   +4.260000e+02 |
> > | max (ns):       |    +9.977030e+05  |  +5.060000e+02 |   +5.060000e+02 |
> > | pk-pk:          |    +9.975520e+05  |  +6.400000e+01 |   +8.000000e+01 |
> 
> I wonder about these worst case measurements of 999 and 998
> milliseconds.  It almost looks like you missed one entire period.
  ^^^^
microseconds

> Could this simply be a bug in the test setup?
> 
> Thanks,
> Richard
