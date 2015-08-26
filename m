From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 26 Aug 2015 09:44:58 -0700
Subject: [Intel-wired-lan] [next-queue] fm10k: use snprintf() instead of
 sprintf() to avoid buffer overflow
In-Reply-To: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
References: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <20150826094458.00007a6c@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 24 Aug 2015 17:01:58 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:

> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c | 6 +++---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)

The changes look fine, but I've seen multiple comments to the list that
there needs to be a body in the commit message.

Suggest:

Subject:
fm10k: use snprintf()

Body:
Avoid buffer overflow and follow best practices by using snprintf()
instead of sprintf().

