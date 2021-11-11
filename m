From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 Nov 2021 13:44:29 -0800
Subject: [Intel-wired-lan] [PATCH net v1] e100: fix device suspend/resume
In-Reply-To: <20211111213722.606364-1-jesse.brandeburg@intel.com>
References: <20211111213722.606364-1-jesse.brandeburg@intel.com>
Message-ID: <0e247faf-77d3-c05b-88c3-515b612d0c3f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/11/2021 1:37 PM, Jesse Brandeburg wrote:
> As reported in [1], e100 was no longer working for suspend/resume
> cycles. The previous commit mentioned in the fixes appears to have
> broken things and this attempts to practice best known methods for
> device power management and keep wake-up working while allowing
> suspend/resume to work. To do this, I reorder a little bit of code
> and fix the resume path to make sure the device is enabled.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=214933
> 
> Reported-by: Alexey Kuznetsov <axet@me.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Please drop v1, v2 sent.

