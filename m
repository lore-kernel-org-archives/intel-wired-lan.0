From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 21 Apr 2016 11:13:37 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Fix relaxed order settings
	in VF driver
In-Reply-To: <1461259276-54151-1-git-send-email-babu.moger@oracle.com>
References: <1461259276-54151-1-git-send-email-babu.moger@oracle.com>
Message-ID: <CAKgT0UeU+Q1HDvR8pK3kxYofjEqk8jVeh5xONoUpD34MsPZCCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 21, 2016 at 10:21 AM, Babu Moger <babu.moger@oracle.com> wrote:
> Current code writes the tx/rx relaxed order without reading it first.
> This can lead to unintended consequences as we are forcibly writing
> other bits.

The consequences were very much intended as there are situations where
enabling relaxed ordering can lead to data corruption.

> We noticed this problem while testing VF driver on sparc. Relaxed
> order settings for rx queue were all messed up which was causing
> performance drop with VF interface.

What additional relaxed ordering bits are you enabling on Sparc?  I'm
assuming it is just the Rx data write back but I want to verify.

> Fixed it by reading the registers first and setting the specific
> bit of interest. With this change we are able to match the bandwidth
> equivalent to PF interface.
>
> Signed-off-by: Babu Moger <babu.moger@oracle.com>

Fixed is a relative term here since you are only chasing performance
from what I can tell.  We need to make certain that this doesn't break
the driver on any other architectures by leading to things like data
corruption.

- Alex
