From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 26 May 2018 01:24:08 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Clear TSICR interrupts together
 with ICR
In-Reply-To: <dc3f47f4-22b2-87d7-3959-9da530efbfe3@trackman.com>
References: <dc3f47f4-22b2-87d7-3959-9da530efbfe3@trackman.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B964E7C12@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Joanna Yurdal
> Sent: Wednesday, May 16, 2018 4:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: Clear TSICR interrupts together with
> ICR
> 
> I have been working with the PTP using IGB i210 and the linux driver
> can end up in a state where it stops receiving E1000_ICR_TS interrupt.
> The ethernet driver works fine but PPS stops and no tx ptp timestamp
> can be retrieved. This is caused by not clearing the TS interrupt before
> enabling igb interrupts in the igb_up function.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
