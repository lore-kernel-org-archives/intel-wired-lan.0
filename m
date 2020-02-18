From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Tue, 18 Feb 2020 10:07:20 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v3 1/2] igc: Add support
 for taprio offloading
In-Reply-To: <20200214235203.3910513-2-vinicius.gomes@intel.com>
References: <20200214235203.3910513-1-vinicius.gomes@intel.com>
 <20200214235203.3910513-2-vinicius.gomes@intel.com>
Message-ID: <158204924056.42041.6687775774624197860@1.0.0.127.in-addr.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Vinicius Costa Gomes (2020-02-14 15:52:02)
> Adds support for translating taprio schedules into i225 cycles. This
> will allow schedules to run in the hardware, making the schedules
> enforcement more precise and saving CPU time.
> 
> Right now, the only simple schedules are allowed, complex schedules are
> rejected. "simple" in this context are schedules that each HW queue is
> opened and closed only once in each cycle.
> 
> Changing schedules is still not supported as well.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Andre Guedes <andre.guedes@intel.com>
