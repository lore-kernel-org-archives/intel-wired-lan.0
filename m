From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 23 May 2018 14:13:49 -0700
Subject: [Intel-wired-lan] [PATCH v2] Documentation: e1000: Update
 kernel documentation
In-Reply-To: <20180510195538.19124-1-jeffrey.t.kirsher@intel.com>
References: <20180510195538.19124-1-jeffrey.t.kirsher@intel.com>
Message-ID: <04010a0c-f3b1-e04c-3dfc-49e8746b8925@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/10/2018 12:55 PM, Jeff Kirsher wrote:
> Updated the e1000.txt kernel documentation with the latest information.
> 
> Also convert the text file to reStructuredText (RST) format, since the
> Linux kernel documentation now uses this format for documentation.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v2: fix the broken URL
> 
>   .../networking/{e1000.txt => e1000.rst}       | 59 ++++---------------
>   Documentation/networking/index.rst            |  1 +
>   MAINTAINERS                                   |  2 +-
>   3 files changed, 12 insertions(+), 50 deletions(-)
>   rename Documentation/networking/{e1000.txt => e1000.rst} (89%)
> 
> diff --git a/Documentation/networking/e1000.txt b/Documentation/networking/e1000.rst
> similarity index 89%
> rename from Documentation/networking/e1000.txt
> rename to Documentation/networking/e1000.rst
> index 1f6ed848363d..616848940e63 100644
> --- a/Documentation/networking/e1000.txt
> +++ b/Documentation/networking/e1000.rst

Do you want to update your copyright date?

sln

