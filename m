From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 22:32:59 +0000
Subject: [Intel-wired-lan] [PATCH v1 00/13] Fix several GCC6 warnings
In-Reply-To: <CAKgT0UfDoSrRW5S_xSiireqMoXkB0B4tqjZ5gxLReMQ=4bQG4A@mail.gmail.com>
References: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
 <CAKgT0UfDoSrRW5S_xSiireqMoXkB0B4tqjZ5gxLReMQ=4bQG4A@mail.gmail.com>
Message-ID: <1460586779.9106.39.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-04-13 at 14:57 -0700, Alexander Duyck wrote:
> On Wed, Apr 13, 2016 at 2:31 PM, Jacob Keller <jacob.e.keller@intel.c
> om> wrote:
> > 
> > This patch series fixes several warnings on Intel(R) drivers,
> > including
> > for igb, igbvf, e1000e, ixgbe, ixgbevf, i40e, i40evf and fm10k.
> > 
> > The primary change is to use BIT() macro where appropriate, and use
> > the
> > unsigned postfix for various other bitshifts. While much of this 
> > change
> > doesn't prevent any current warnings, it helps ensure that future
> > additions make use of BIT() macro or the unsigned postfix and
> > prevent
> > signed bitshift errors in the future. A few places (especially in
> > ixgbe)
> > don't use BIT even though it's technically equivalent for style and
> > understanding the real intent of the code.
> > 
> > The series also fixes some other warnings, and makes use of GENMASK
> > in a
> > few locations.
> So after looking over a few patches I would say you are bit to eager
> to apply BIT to things, and there are a few places where GENMASK
> should be used that you were using bit.
> 
> Specifically in the cases where we are shifting a value that just
> happens to be a 1 by some shift I would recommend not using the BIT
> macro.??Such cases are the context descriptor index value or the
> version number for ethtool.??In addition I am not sure it makes much
> sense to use BIT when we are calculating 2 to the power of a given
> value.??For example PAGE_SIZE is defined at (1 << PAGE_SHIFT), not
> BIT(PAGE_SHIFT) within the kernel.
> 
> You probably need to apply GENMASK in all the cases where we have
> BIT(x) - 1 being used.??You will want to set it up as GENMASK(x - 1,
> 0).
> 
> - Alex

Yep. I'll try to clean those up.

Thanks,
Jake
