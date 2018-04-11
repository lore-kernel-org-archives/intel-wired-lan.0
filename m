From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 11 Apr 2018 10:03:24 -0700
Subject: [Intel-wired-lan] [PATCH] intel: Cleanup the copyright/license
 headers
In-Reply-To: <20180411162708.10683-1-jeffrey.t.kirsher@intel.com>
References: <20180411162708.10683-1-jeffrey.t.kirsher@intel.com>
Message-ID: <9bcd0fa6-89e3-093f-cfb3-26a7c49b038b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/11/2018 9:27 AM, Jeff Kirsher wrote:
> After many years of having a ~30 line copyright and license header to our
> source files, we are finally able to reduce that to one line with the
> advent of the SPDX identifier.
> 
> Also caught a few files missing the SPDX license identifier, so fixed
> them up.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> Richard - I did not touch the igb_ptp.c header, since you have Copyright on
> that file.
> 
> Shannon - I did not touch the ixgbe_ipsec.* headers, since you/Oracle
> have Copyright on those two files.
>

Hi Jeff - thanks for your consideration.  Matching the rest of the 
driver files with the SPDX and a one-line copyright should be fine:

// SPDX-License-Identifier: GPL-2.0
/* Copyright(c) 2017 Oracle and/or its affiliates. */

Cheers,
sln
