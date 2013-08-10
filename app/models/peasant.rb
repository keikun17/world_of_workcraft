class Peasant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me

  after_save :make_searchable, :send_notification_email, :create_single_page_pdf

  def make_searchable
    SearchEngine.something(self)
  end

  def create_single_page_pdf
    worker_params = {}
    worker_params[:queue_name] = 'user_pdf_queue'
    worker_params[:worker_class] = 'PdfWorker'
    worker_params[:options] = { single_page: true,
                                template: 'user_template.pdf',
                                body: user.pdf_data  }
    BackgroundWorker.enqueue(:pdf_job, pdf_details: self)
  end


  def send_notification_email
    UserMailer.notify_user(peasant)
  end

  private

  def pdf_data
    include ActionView::Helpers::DateHelper
    data = {
            first_name: first_name,
            last_name: last_name,
            address: address,
            accomplishments: accomplishments.to_sentence,
            year_in_service: time_ago_in_words
    }

    data

  end

end
