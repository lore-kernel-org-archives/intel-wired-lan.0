From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Date: Tue, 2 Mar 2021 06:27:39 +0100
Subject: [Intel-wired-lan] [PATCH] e1000e: use proper #include guard
 name in hw.h
In-Reply-To: <df502c9f145e8ca26d7c79f291fc7abd48066b88.camel@intel.com>
References: <20210227095858.604463-1-gregkh@linuxfoundation.org>
 <df502c9f145e8ca26d7c79f291fc7abd48066b88.camel@intel.com>
Message-ID: <YD3Myz2psace5IqO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 02, 2021 at 01:37:59AM +0000, Nguyen, Anthony L wrote:
> On Sat, 2021-02-27 at 10:58 +0100, Greg Kroah-Hartman wrote:
> > The include guard for the e1000e and e1000 hw.h files are the same,
> > so
> > add the proper "E" term to the hw.h file for the e1000e driver.
> 
> There's a patch in process that addresses this issue [1].

Thanks, hopefully it gets fixed somehow :)

greg k-h
