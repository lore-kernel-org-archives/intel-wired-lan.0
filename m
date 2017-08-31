From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 31 Aug 2017 16:45:37 -0700
Subject: [Intel-wired-lan] [PATCH 31/31] timer: Switch to testing for
	.function instead of .data
In-Reply-To: <1504222183-61202-32-git-send-email-keescook@chromium.org>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
 <1504222183-61202-32-git-send-email-keescook@chromium.org>
Message-ID: <CAKdAkRTSgs+JTKRa2nvcSPD+zQ5OhsLx_aM8WaZyg304QQN3hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 31, 2017 at 4:29 PM, Kees Cook <keescook@chromium.org> wrote:
> In several places, .data is checked for initialization to gate early
> calls to del_timer_sync(). Checking for .function is equally valid, so
> switch to this in all callers.

Not seeing the rest of patches it is unclear from the patch
description why this is needed/wanted.

Thanks.

-- 
Dmitry
