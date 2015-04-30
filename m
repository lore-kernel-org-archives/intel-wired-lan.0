From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2015 23:10:27 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix LINUX_VERSION's use of
	EXTRA_CFLAGS
In-Reply-To: <1430435381-6028-1-git-send-email-jacob.e.keller@intel.com>
References: <1430435381-6028-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1430435427.25212.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-04-30 at 16:09 -0700, Jacob Keller wrote:
> In order not to override any CFLAGS_EXTRA from the command line, we
> create an extra variable EXTRA_CFLAGS which contains our introductino of
> LINUX_VERSION_CODE, and append CFLAGS_EXTRA to this. However, the i40e
> driver never did this previously, so it passed CFLAGS_EXTRA directly
> into the kernel build rule. This patch fixes the issue by using
> EXTRA_CFLAGS in its place. Without LINUX_VERSION, EXTRA_CFLAGS is
> equivalent to CFLAGS_EXTRA.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-type: Build Change
> Complexity: Low
> Customer-visible: No
> ---

Hah. I sent this to the wrong list, you can safely ignore this. 

Regards,
Jake
