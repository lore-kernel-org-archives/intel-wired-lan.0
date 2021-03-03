From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 3 Mar 2021 01:07:09 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix to not show opcode
 msg on unsuccessful VF MAC change
In-Reply-To: <20210302151904.13288-1-mateusz.palczewski@intel.com>
References: <20210302151904.13288-1-mateusz.palczewski@intel.com>
Message-ID: <215932bb6dc3c90f003ce1fa1d6b52e105a5126b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-03-02 at 15:19 +0000, Mateusz Palczewski wrote:
> Hide i40e opcode information sent during response to VF in case when
> untrusted VF tried to change MAC on the VF interface.
> 
> This is implemented by adding an additional parameter 'hide' to the
> response sent to VF function that hides the display of error
> information, but forwards the error code to VF.
> 
> Previously it was not possible to send response with some error code
> to VF without displaying opcode information.
> 
> Fixes: 5c3c48ac6bf5("i40e: implement virtual device interface")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>

ERROR: Missing Signed-off-by: line by nominal patch author 'Mateusz
Palczewski <mateusz.palczewski@intel.com>'

> Reviewed-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---

Please include a revision history of what changed between versions.

>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 44 +++++++++++++++
> ----
>  1 file changed, 35 insertions(+), 9 deletions(-)
