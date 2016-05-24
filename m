From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 24 May 2016 20:57:36 +0000
Subject: [Intel-wired-lan] [PATCH v4 1/5] igb: introduce ptp_flags
 variable and use it to replace IGB_FLAG_PTP
In-Reply-To: <20160524205631.21225-1-jacob.e.keller@intel.com>
References: <20160524205631.21225-1-jacob.e.keller@intel.com>
Message-ID: <1464123457.5045.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-05-24 at 13:56 -0700, Jacob Keller wrote:
> Upcoming patches will introduce new PTP specific flags. To avoid
> cluttering the normal flags variable, introduce PTP specific
> "ptp_flags"
> variable for this purpose, and move IGB_FLAG_PTP to become
> IGB_PTP_ENABLED.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

For reference, I attached the interseries difference between v3 and v4.

Thanks,
Jake
-------------- next part --------------
A non-text attachment was scrubbed...
Name: interdiff-v3-v4.patch
Type: text/x-patch
Size: 1396 bytes
Desc: interdiff-v3-v4.patch
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160524/a104e891/attachment.bin>
