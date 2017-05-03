From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 3 May 2017 08:43:48 -0700
Subject: [Intel-wired-lan] [PATCH] igb: Fix error that repeat to add
 filter when changing adapter speed
In-Reply-To: <1493774409-7536-1-git-send-email-gangfeng.huang@ni.com>
References: <1493774409-7536-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <20170503084348.0000464c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 3 May 2017 09:20:09 +0800
Gangfeng <gangfeng.huang@ni.com> wrote:

> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> Function igb_nfc_filter_exit()/igb_nfc_filter_restore() should be paried,
> igb_nfc_filter_restore exist in igb_up(), but igb_nfc_filter_exit() exist
> in __igb_close(), so move the igb_nfc_filter_exit() to igb_down().

Hi, thanks for your patch.  Are you fixing a bug here? If so, your
commit message should say what you're fixing and how to reproduce it.
Say why you are doing something, not just what you're doing.

In this case, it looks like you probably are fixing a bug, but
definitely need a better commit message.
