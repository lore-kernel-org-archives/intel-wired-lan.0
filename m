From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Fri, 14 Sep 2018 13:39:17 +0900
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 00/14] rename and
 shrink i40evf
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180914043917.GB24996@f2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/09/13 15:31, Jesse Brandeburg wrote:
[...]
> 
> ---
> v1: initial RFC
> 
> Jesse Brandeburg (14):
>   intel-ethernet: rename i40evf to iavf

Seems like patch 1 didn't make it to netdev
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20180910/014025.html

>   iavf: diet and reformat
>   iavf: rename functions and structs to new name
>   iavf: rename i40e_status to iavf_status
>   iavf: move i40evf files to new name
>   iavf: remove references to old names
>   iavf: rename device ID defines
>   iavf: rename I40E_ADMINQ_DESC
>   iavf: rename i40e_hw to iavf_hw
>   iavf: replace i40e_debug with iavf version
>   iavf: tracing infrastructure rename
>   iavf: rename most of i40e strings
>   iavf: finish renaming files to iavf
>   intel-ethernet: use correct module license
