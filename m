From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 22 Mar 2021 21:17:07 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <87czvrkxol.fsf@vcostago-mobl2.amr.corp.intel.com>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com>
 <20201117014926.GA26272@hoboy.vegasvil.org>
 <87d00b5uj7.fsf@intel.com>
 <20201118125451.GC23320@hoboy.vegasvil.org>
 <87czvrkxol.fsf@vcostago-mobl2.amr.corp.intel.com>
Message-ID: <20210323041707.GB25323@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 22, 2021 at 08:36:26AM -0700, Vinicius Costa Gomes wrote:
> After a long time, a couple of internal misunderstandings, fixing some
> typos in the delay adjustment constants and better error handling, this
> one shot method is working well.
> 
> I will propose a new version, implementing PTP_SYS_OFFSET_PRECISE using
> the one shot way.

+1
