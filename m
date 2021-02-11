From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 Feb 2021 10:25:13 -0800
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix NULL ptr dereference
 on VSI filter sync
In-Reply-To: <1613042941-31948-1-git-send-email-michal.maloszewski@intel.com>
References: <1613042941-31948-1-git-send-email-michal.maloszewski@intel.com>
Message-ID: <20210211102513.00003b57@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Micha? Ma?oszewski wrote:

> ---
> v2: permissions are changed
> 
>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/net/ethernet/intel/i40e/i40e.h
>  mode change 100644 => 100755 drivers/net/ethernet/intel/i40e/i40e_main.c

Please fix your git commit, this file permission change making the
files 100755 (executable!) doesn't make any sense and will be rejected
upstream, so I'm rejecting it here.

You must resubmit a v3 please without the 755 changes.
in your tree:
chmod 644 drivers/net/ethernet/intel/i40e/i40e.h drivers/net/ethernet/intel/i40e/i40e_main.c
git add -u
git commit --amend

