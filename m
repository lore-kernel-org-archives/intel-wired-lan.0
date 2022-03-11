From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 11 Mar 2022 22:45:05 +0100
Subject: [Intel-wired-lan] [PATCH linux-firmware v2] ice: update ice DDP
 comms package to 1.3.31.0
In-Reply-To: <20220311185025.2243-1-arjun.anantharam@intel.com>
References: <20220311185025.2243-1-arjun.anantharam@intel.com>
Message-ID: <a9c44b4f-ef51-4e0e-2db2-04c9e4b154fb@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Arjun,


Am 11.03.22 um 19:50 schrieb Arjun Anantharam:
> Update ice DDP comms package file to the latest version: 1.3.31.0
> 
> Highlight of changes since 1.3.20.0:
> 
> -Added Separate Package Type Group for outer IPv4 and IPv6
> tunnel packet
> -Added GTPU SCTP ptypes to PTGs mapping
> -Added Multicast support in Flow Director
> -Added profiles for GTPU extension header

Thank you for extending the commit message.

Two nits: It?d be great if you added a space after the (bullet) hyphen, 
and used imperative mood:

- Add Separate Package Type Group ?

> Signed-off-by: Arjun Anantharam <arjun.anantharam@intel.com>

[?]

The rest looks good.


Kind regards,

Paul
