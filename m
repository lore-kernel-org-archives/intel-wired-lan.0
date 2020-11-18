From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 18 Nov 2020 07:55:34 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <87d00b5uj7.fsf@intel.com>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com>
 <20201117014926.GA26272@hoboy.vegasvil.org>
 <87d00b5uj7.fsf@intel.com>
Message-ID: <20201118075534.2a5e63c4@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 17 Nov 2020 17:21:48 -0800 Vinicius Costa Gomes wrote:
> > Also, what is the point of providing time measurements every 1
> > millisecond?  
> 
> I sincerely have no idea. I had no power on how the hardware was
> designed, and how PTM was implemented in HW.

Is the PTMed latency not dependent on how busy the bus is?
That'd make 1ms more reasonable.
