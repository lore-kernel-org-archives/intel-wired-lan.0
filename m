From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 26 Feb 2021 14:30:32 -0800
Subject: [Intel-wired-lan] [PATCH net 2/2] igb: Fix duplicate include
 guard
In-Reply-To: <20210222040005.20126-2-tseewald@gmail.com>
References: <20210222040005.20126-1-tseewald@gmail.com>
 <20210222040005.20126-2-tseewald@gmail.com>
Message-ID: <20210226143032.00005184@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Tom Seewald wrote:

> The include guard "_E1000_HW_H_" is used by two separate header files in
> two different drivers (e1000/e1000_hw.h and igb/e1000_hw.h). Using the
> same include guard macro in more than one header file may cause
> unexpected behavior from the compiler. Fix this by renaming the
> duplicate guard in the igb driver.
> 
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> Signed-off-by: Tom Seewald <tseewald@gmail.com>

Change is simple and makes sense.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
