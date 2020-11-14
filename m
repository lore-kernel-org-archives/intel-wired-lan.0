From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 13 Nov 2020 18:57:04 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <87ima96pj1.fsf@intel.com>
References: <20201112093203.GH1559650@localhost> <87pn4i6svv.fsf@intel.com>
 <20201113032451.GB32138@hoboy.vegasvil.org>
 <87ima96pj1.fsf@intel.com>
Message-ID: <20201114025704.GA15240@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Nov 13, 2020 at 11:10:58AM -0800, Vinicius Costa Gomes wrote:
> I am proposing a series that adds support for PCIe PTM (for the igc
> driver), exporting the values via the PTP_SYS_OFFSET_PRECISE ioctl().
> 
> The way PTM works in the NIC I have, kind of forces me to start the PTM
> dialogs during initialization, and they are kept running in background,
> what the _PRECISE ioctl() does is basically collecting the most recent
> measurement.

What is a PTM?  Why does a PTM have dialogs?  Can it talk?

Forgive my total ignorance!

Thanks,
Richard
