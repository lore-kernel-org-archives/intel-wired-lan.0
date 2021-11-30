From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 30 Nov 2021 21:42:33 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix for failed to init
 adminq while VF reset
In-Reply-To: <20211130073211.1114232-1-karen.sornek@intel.com>
References: <20211130073211.1114232-1-karen.sornek@intel.com>
Message-ID: <8f454effc188a4e01b758caa9579f933621c381e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-11-30 at 08:32 +0100, Sornek, Karen wrote:
> From: Karen Sornek <karen.sornek@intel.com>
> 
> Fix for failed to init adminq: -53 while VF is resetting via MAC
> address changing procedure.
> Added sync module to avoid reading deadbeef value in reinit adminq
> during software reset.
> Without this patch it is possible to trigger VF reset procedure
> during reinit adminq. This resulted in an incorrect reading of
> value from the AQP registers and generated the -53 error.
> 

If this is for net, it needs a Fixes:

> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
