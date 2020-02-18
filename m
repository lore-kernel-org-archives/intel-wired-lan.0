From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Tue, 18 Feb 2020 10:07:31 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v3 2/2] igc: Add support
 for ETF offloading
In-Reply-To: <20200214235203.3910513-3-vinicius.gomes@intel.com>
References: <20200214235203.3910513-1-vinicius.gomes@intel.com>
 <20200214235203.3910513-3-vinicius.gomes@intel.com>
Message-ID: <158204925112.42041.14818320744953321769@1.0.0.127.in-addr.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Vinicius Costa Gomes (2020-02-14 15:52:03)
> This adds support for ETF offloading for the i225 controller.
> 
> For i225, the LaunchTime feature is almost a subset of the Qbv
> feature. The main change from the i210 is that the launchtime of each
> packet is specified as an offset applied to the BASET register. BASET
> is automatically incremented each cycle.
> 
> For i225, the approach chosen is to re-use most of the setup used for
> taprio offloading. With a few changes:
> 
>  - The more or less obvious one is that when ETF is enabled, we should
>  set add the expected launchtime to the (advanced) transmit
>  descriptor;
> 
>  - The less obvious, is that when taprio offloading is not enabled, we
>  add a dummy schedule (all queues are open all the time, with a cycle
>  time of 1 second).
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Andre Guedes <andre.guedes@intel.com>
