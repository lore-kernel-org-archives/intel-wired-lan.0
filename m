From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 18 Nov 2020 04:54:51 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <87d00b5uj7.fsf@intel.com>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com>
 <20201117014926.GA26272@hoboy.vegasvil.org>
 <87d00b5uj7.fsf@intel.com>
Message-ID: <20201118125451.GC23320@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 17, 2020 at 05:21:48PM -0800, Vinicius Costa Gomes wrote:
> Agreed that would be easiest/simplest. But what I have in hand seems to
> not like it, i.e. I have an earlier series implementing this "one shot" way
> and it's not reliable over long periods of time or against having the
> system time adjusted.

Before we go inventing a new API, I think we should first understand
why the one shot thing fails.

If there is problem with the system time being adjusted during PTM,
then that needs solving in any case!

Thanks,
Richard
