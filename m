From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 18 Aug 2020 14:36:15 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] igc: Fix wrong timestamp latency
 numbers
In-Reply-To: <20200817231231.2971207-1-vinicius.gomes@intel.com>
References: <20200817231231.2971207-1-vinicius.gomes@intel.com>
Message-ID: <20200818143615.00000f16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vinicius Costa Gomes wrote:

> The previous timestamping latency numbers were obtained by
> interpolating the i210 numbers with the i225 crystal clock value. That
> calculation was wrong.
> 
> Use the correct values from real measurements.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Is this targeted at net or net-next, and because it is a fix I
recommend you have subject
[PATCH net 1/2]

and you should include a "Fixes:" tag since this driver has been
released in previous kernels.

